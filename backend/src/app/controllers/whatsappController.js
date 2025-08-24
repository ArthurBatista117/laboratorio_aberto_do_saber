class whatsappController {
    sendMessage = async (req, res) => {
        const { to, message } = req.body;

        try {
            const response = await axios.post(
                `https://graph.facebook.com/v19.0/${743702862165598}/messages`,
                {
                    messaging_product: "whatsapp",
                    to,
                    type: "text",
                    text: { body: message },
                },
                {
                    headers: {
                        Authorization: `Bearer ${EAASZAAV5zBMsBPVmUuUSyAG0Vptoi4Xbtqza2ZAgKFUZCdYADijkLLc70sMmqR2eFJo96VqHjrZBVVsajdFsZCrpcQxw4fXzhFayHxW9gmfrfkSfwPqD4Wy8UpUjvhvQHcOX4Sp1KmoLyTGWOiwmPBEVLVZBEUtPzYAireaiK9ddKtJqEJOqJQOTtMSZBpwJRZAiz8WarSOiJGhZCzWb5gSG5zZAYX3pZBHJZCcGaryjT6LpuannUgZDZD}`,
                        "Content-Type": "application/json",
                    },
                }
            );

            res.json({ success: true, data: response.data });
        } catch (error) {
            console.error(error.response?.data || error.message);
            res.status(500).json({ success: false, error: error.message });
        }
    }
}

module.exports = new whatsappController(); 