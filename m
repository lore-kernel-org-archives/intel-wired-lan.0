From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 12 Oct 2015 09:54:23 -0700
Subject: [Intel-wired-lan] [iproute2 PATCH] iplink: Support VF Trust
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05F42A95@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05F42A95@BPXM14GP.gisp.nec.co.jp>
Message-ID: <20151012095423.4feabde1@urahara>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 7 Oct 2015 10:06:32 +0000
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

I am waiting until this is accepted into kernel before merging it into iproute2.

