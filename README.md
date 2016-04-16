这是一个个人实验性分支。

跟项目核心关系不大，有愿意研究的就看看。


备注：


1. dnsmasq 将几个主要的支持HSTS的域名劫持到CTM的SNI-PROXY服务器

2. 由于CTM的SNI-PROXY服务器不支持HTTP的反向代理，路由器本地NGINX建立WEBSERVER，泛解析工作在88端口，通过iptables将所有去往SNI-PROXY服务器80端口的请求劫持到本机的88端口交由NGINX处理，NGINX上的处理一致为跳转到同请求的https网站。

3. 港澳的SNI-PROXY缓存系统均不支持www.google.com，所以将www.google.com的请求劫持到www.google.com.hk，单开NGINX虚拟主机处理这个请求

4. OpenWRT router通过openconnect协议连接到位于Linode Tokyo的Cisco Anyconnect Server. 获取一个IPv4地址，和一个子网为/64的IPv6地址，同时该IPv6地址所在的/80地址块路由给本路由器，在这里配置connect接口关闭默认路由。

5. OpenWRT router在本地br-lan接口手动制定一个上段提到的/80地址块的单IP，开启NDP。这样所有局域网内的用户自动获取IP时会获取到一个该块内的IPv6 IP.

6. 使用hotplug.d触发机制，在openconnect连接成功和断开连接时，自动添加删除ipv6默认路由。同时，处理dns污染问题(详情见下条)。

7. 建立多个dnsmasq配置文件。dnsmasq.ipv4为默认，dnsmasq.ipv6为ipv6链路正常时，将一系列经常性被国内污染的重点域名的解析服务器指定为linode IPv6 DNS Server。由于默认ipv6路由通过vpn透传，这样这些特殊域名可以避免污染的从linode dns解析。同时添加去往8.8.8.8/8.8.4.4的路由通过vpn出去，这个主要并不用于解析，而是用于测试。事实证明，把主要通用dns解析服务器设置为距离较远的服务器，会严重降低网络速度，主要是中国国内大站都已经通过CDN将服务器作用于直接压到了用户最近的机房。
