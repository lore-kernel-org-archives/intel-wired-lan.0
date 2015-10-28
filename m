From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Wed, 28 Oct 2015 16:40:16 +0900
Subject: [Intel-wired-lan] [PATCH v2 net-next 0/4] Automatic adjustment
	of max frame size
In-Reply-To: <20151028135820.72329de4@samsung9>
References: <1445830859-4651-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <20151028135820.72329de4@samsung9>
Message-ID: <56307BE0.5080606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 15/10/28 (?) 13:58, Stephen Hemminger wrote:
> On Mon, 26 Oct 2015 12:40:55 +0900
> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
...

Thank you for taking a look at the patch set.
I'm not sure if I fully understand you, so please correct me if I 
misread you.

> The problem is that you require changing network device drivers
> and device specific knowledge about what will work or not. Because
> of that the modificaton can't be automated.

I'm not sure what you mean by "device specific knowledge" and "automated"...
Indeed, this requires change in each driver.
But required changes in drivers should be mostly making use of 
ndo_change_mtu implementation code and not hard. We can progressively 
implement ndo_enc_hdr_len for each driver.
If max frame size cannot be changed on a certain NIC, vlan driver will 
emit a warning message and make MTU smaller, then userspace can handle 
it (patch 3). If needed, maybe we can expose this feature via ethtool.

>
> Also, this effects even more layered devices like tunnels etc.

Yes, if tunnel devices start to utilize this framework. This is one of 
purposes of my patch set.

> The problem is quite large, and this patch only begins to address it.

Yes, this is the first step to address the problem.

>
> It seems to me that just having the vlan driver to a sane
> auto default is the best solution.

For now, this patch implementation is limited to vlan. For other 
protocols, auto-expansion may not be suitable and may need some nob to 
use the framework.

If you mean just making MTU smaller on vlan device instead of adjusting 
max frame size of real device, then it would not work. 802.1ad HW 
switches, at any rate, send 1526 bytes frames so they will be dropped on 
the real device.

> It might cause a smaller MTU
> than ideal, but at least it will still work. Then the user can
> manually set a larger MTU if they know their hardware will work.

Toshiaki Makita
