From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 2 Mar 2016 09:20:17 -0800
Subject: [Intel-wired-lan] [PATCH iproute2 v2] iplink: Support VF Trust
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05FB353F@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05FB353F@BPXM14GP.gisp.nec.co.jp>
Message-ID: <20160302092017.44982621@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 26 Feb 2016 02:40:18 +0000
Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:

> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Add IFLA_VF_TRUST message to trust the VF.
> PF can accept some privileged operation from the trusted VF.
> For example, ixgbe PF doesn't allow to enable VF promiscuous mode until
> the VF is trusted because it may hurt performance.
> 
> To trust VF.
>  # ip link set dev eth0 vf 1 trust on
> 
> To untrust VF.
>  # ip link set dev eth0 vf 1 trust off
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Applied.
