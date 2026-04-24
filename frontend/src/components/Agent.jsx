import { useState, useEffect, useRef } from 'react';

const Agent = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState([
  ]);
  const [input, setInput] = useState('');
  const [isTyping, setIsTyping] = useState(false); // Added a typing state
  const chatEndRef = useRef(null);

  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, isTyping]);

  const handleSendMessage = async (e) => {
    e.preventDefault();
    if (!input.trim()) return;

    // 1. Show user message
    const userMsg = { role: 'user', text: input };
    setMessages(prev => [...prev, userMsg]);
    const currentInput = input;
    setInput('');
    setIsTyping(true); // Show typing indicator

    try {
      // 2. Connect to your Python backend
      const response = await fetch(`${import.meta.env.VITE_API_URL}/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message: currentInput }),
      });

      if (!response.ok) throw new Error('Backend offline');

      const data = await response.json();

      // 3. Show AI response
      setMessages(prev => [...prev, { role: 'bot', text: data.reply }]);
    } catch (error) {
  console.error("Agent Connection Error:", error); // Use the variable here
  setMessages(prev => [...prev, {

        role: 'bot', 
        text: "Sorry, I can't reach my Python brain right now. Is the server running?" 
      }]);
    } finally {
      setIsTyping(false); // Hide typing indicator
    }
  };

  return (
    <>
      {isOpen && (
        <div className="agent-window">
          <div className="agent-header">
            <span>Mokusei AI</span>
            <button onClick={() => setIsOpen(false)}>&times;</button>
          </div>
          <div className="agent-content">
            {messages.map((msg, i) => (
              <div key={i} className={`message ${msg.role}`}>{msg.text}</div>
            ))}
            {isTyping && <div className="message bot typing">...</div>}
            <div ref={chatEndRef} />
          </div>
          <form className="agent-input" onSubmit={handleSendMessage}>
            <input 
              value={input} 
              onChange={(e) => setInput(e.target.value)} 
              placeholder="Ask me something..." 
              disabled={isTyping} // Disable input while waiting
            />
          </form>
        </div>
      )}
      <div className="agent-trigger" onClick={() => setIsOpen(!isOpen)}>
        <span>{isOpen ? '✕' : '🤖'}</span>
      </div>
    </>
  );
};

export default Agent;
