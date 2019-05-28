From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 28 May 2019 10:18:59 -0700
Subject: [Intel-wired-lan] Driver has suspect GRO implementation,
 TCP performance may be compromised.
In-Reply-To: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
Message-ID: <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/28/19 8:42 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Occasionally, Linux outputs the message below on the workstation Dell
> OptiPlex 5040 MT.
> 
>     TCP: net00: Driver has suspect GRO implementation, TCP performance may be compromised.
> 
> Linux 4.14.55 and Linux 5.2-rc2 show the message, and the WWW also
> gives some hits [1][2].
> 
> ```
> $ sudo ethtool -i net00
> driver: e1000e
> version: 3.2.6-k
> firmware-version: 0.8-4
> expansion-rom-version: 
> bus-info: 0000:00:1f.6
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: no
> ```
> 
> Can the driver e1000e be improved?
> 
> Any idea, what triggers this, as I do not see it every boot? Download
> of big files?
>
Maybe the driver/NIC can receive frames bigger than MTU, although this would be strange.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c61edd023b352123e2a77465782e0d32689e96b0..cb0194f66125bcba427e6e7e3cacf0c93040ef61 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -150,8 +150,10 @@ static void tcp_gro_dev_warn(struct sock *sk, const struct sk_buff *skb,
                rcu_read_lock();
                dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
                if (!dev || len >= dev->mtu)
-                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised.\n",
-                               dev ? dev->name : "Unknown driver");
+                       pr_warn("%s: Driver has suspect GRO implementation, TCP performance may be compromised."
+                               " len %u mtu %u\n",
+                               dev ? dev->name : "Unknown driver",
+                               len, dev ? dev->mtu : 0);
                rcu_read_unlock();
        }
 }

