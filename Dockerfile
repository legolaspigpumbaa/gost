FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y iptables iptables-persistent && \
    rm -rf /var/lib/apt/lists/*

# Enable IP forwarding
RUN sysctl net.ipv4.ip_forward=1

# Set up NAT rules for TCP
RUN iptables -t nat -A POSTROUTING -p tcp --match multiport --dports 80,443 -j MASQUERADE && \
    iptables -t nat -A PREROUTING -p tcp --match multiport --dports 80,443 -j DNAT --to-destination http://64.227.32.106/

# Set up NAT rules for UDP
RUN iptables -t nat -A POSTROUTING -p udp -j MASQUERADE && \
    iptables -t nat -A PREROUTING -p udp -j DNAT --to-destination http://64.227.32.106/

# Save iptables rules to file
RUN mkdir -p /etc/iptables/ && \
    iptables-save | tee /etc/iptables/rules.v4

# Expose any necessary ports if needed
# EXPOSE ...

# You can add CMD or ENTRYPOINT here if you want the container to do something specific when it starts
