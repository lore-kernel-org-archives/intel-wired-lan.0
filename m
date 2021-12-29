From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Wed, 29 Dec 2021 13:46:14 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v2] net: don't include
 filter.h from net/sock.h
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
References: <20211229004913.513372-1-kuba@kernel.org>
Message-ID: <081437ff-a69d-faf5-0981-389156a90668@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 29/12/2021 02:49, Jakub Kicinski wrote:
> sock.h is pretty heavily used (5k objects rebuilt on x86 after
> it's touched). We can drop the include of filter.h from it and
> add a forward declaration of struct sk_filter instead.
> This decreases the number of rebuilt objects when bpf.h
> is touched from ~5k to ~1k.
> 
> There's a lot of missing includes this was masking. Primarily
> in networking tho, this time.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba at kernel.org/
>  - fix build in bond on ia64
>  - fix build in ip6_fib with randconfig
> 
> CC: marcel at holtmann.org
> CC: johan.hedberg at gmail.com
> CC: luiz.dentz at gmail.com
> CC: dledford at redhat.com
> CC: jgg at ziepe.ca
> CC: mustafa.ismail at intel.com
> CC: shiraz.saleem at intel.com
> CC: leon at kernel.org
> CC: ap420073 at gmail.com
> CC: wg at grandegger.com
> CC: woojung.huh at microchip.com
> CC: andrew at lunn.ch
> CC: vivien.didelot at gmail.com
> CC: f.fainelli at gmail.com
> CC: olteanv at gmail.com
> CC: george.mccollister at gmail.com
> CC: michael.chan at broadcom.com
> CC: jesse.brandeburg at intel.com
> CC: anthony.l.nguyen at intel.com
> CC: ast at kernel.org
> CC: daniel at iogearbox.net
> CC: hawk at kernel.org
> CC: john.fastabend at gmail.com
> CC: tariqt at nvidia.com
> CC: saeedm at nvidia.com
> CC: ecree.xilinx at gmail.com
> CC: habetsm.xilinx at gmail.com
> CC: jreuter at yaina.de
> CC: dsahern at kernel.org
> CC: kvalo at codeaurora.org
> CC: pkshih at realtek.com
> CC: trond.myklebust at hammerspace.com
> CC: anna.schumaker at netapp.com
> CC: viro at zeniv.linux.org.uk
> CC: andrii at kernel.org
> CC: mcgrof at kernel.org
> CC: keescook at chromium.org
> CC: yzaikin at google.com
> CC: nikolay at nvidia.com
> CC: jiri at nvidia.com
> CC: wintera at linux.ibm.com
> CC: wenjia at linux.ibm.com
> CC: pablo at netfilter.org
> CC: kadlec at netfilter.org
> CC: fw at strlen.de
> CC: ralf at linux-mips.org
> CC: jhs at mojatatu.com
> CC: xiyou.wangcong at gmail.com
> CC: kgraul at linux.ibm.com
> CC: sgarzare at redhat.com
> CC: steffen.klassert at secunet.com
> CC: herbert at gondor.apana.org.au
> CC: arnd at arndb.de
> CC: linux-bluetooth at vger.kernel.org
> CC: linux-rdma at vger.kernel.org
> CC: linux-can at vger.kernel.org
> CC: intel-wired-lan at lists.osuosl.org
> CC: bpf at vger.kernel.org
> CC: linux-hams at vger.kernel.org
> CC: ath11k at lists.infradead.org
> CC: linux-wireless at vger.kernel.org
> CC: linux-nfs at vger.kernel.org
> CC: linux-fsdevel at vger.kernel.org
> CC: bridge at lists.linux-foundation.org
> CC: linux-decnet-user at lists.sourceforge.net
> CC: linux-s390 at vger.kernel.org
> CC: netfilter-devel at vger.kernel.org
> CC: coreteam at netfilter.org
> CC: virtualization at lists.linux-foundation.org
> ---
[snip]
>  net/bridge/br_ioctl.c                             | 1 +
[snip
>  70 files changed, 80 insertions(+), 1 deletion(-)
> 

For the bridge:
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


