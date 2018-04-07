From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 7 Apr 2018 02:19:27 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v6 10/10] igb: Add support
 for adding offloaded clsflower filters
In-Reply-To: <20180329210751.11531-11-vinicius.gomes@intel.com>
References: <20180329210751.11531-1-vinicius.gomes@intel.com>
 <20180329210751.11531-11-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C82598F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Vinicius Costa Gomes
> Sent: Thursday, March 29, 2018 2:08 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: [Intel-wired-lan] [next-queue PATCH v6 10/10] igb: Add support for
> adding offloaded clsflower filters
> 
> This allows filters added by tc-flower and specifying MAC addresses,
> Ethernet types, and the VLAN priority field, to be offloaded to the
> controller.

Can I get a brief explanation for enabling this?  I'm currently happy with this patch series from a regression perspective, but am personally a bit, umm, challenged with tc in general but would like to run it through the paces a bit.  If it can be done in a one or two liner I think it would be a good addition to the patch description.

> 
> This reuses most of the infrastructure used by ethtool, but clsflower
> filters are kept in a separated list, so they are invisible to
> ethtool.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |   2 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 188
> +++++++++++++++++++++++++++++-
>  2 files changed, 188 insertions(+), 2 deletions(-)

