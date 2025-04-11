resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = file("C:\\Users\\mithunpp\\.ssh\\id_ed25519.pub")
  
}