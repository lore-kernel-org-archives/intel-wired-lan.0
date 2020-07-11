From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 11 Jul 2020 11:14:21 -0700
Subject: [Intel-wired-lan] [PATCH] xsk: ixgbe: solve the soft interrupt
 100% CPU usage when xdp rx traffic congestion
In-Reply-To: <1594462239-19596-1-git-send-email-goodluckwillcomesoon@gmail.com>
References: <1594462239-19596-1-git-send-email-goodluckwillcomesoon@gmail.com>
Message-ID: <20200711111421.0db76fa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 11 Jul 2020 18:10:38 +0800 Yahui Chen wrote:
> 2. If the wakeup mechanism is used, that is, use the
> `XDP_UMEM_USES_NEED_WAKEUP` flag. This method takes advantage of the
> interrupt delay function of ixgbe skillfully, thus solving the problem
> that the si CPU is always 100%. However, it will cause other problems.
> The port-level flow control will be triggered on 82599, and the pause
> frame will be sent to the upstream sender. This will affect the other
> packet receiving queues of the network card, resulting in the packet
> receiving rate of all queues dropping to 10Kpps.

To me the current behavior sounds correct.. if you don't want pause
frames to be generated you have to disable them completely. The point 
of pause frames is to prevent drops.
