From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 20 Jul 2020 02:10:46 +0200
Subject: [Intel-wired-lan] [PATCH ethtool 0/4] Add support for IGC driver
In-Reply-To: <20200707234800.39119-1-andre.guedes@intel.com>
References: <20200707234800.39119-1-andre.guedes@intel.com>
Message-ID: <20200720001046.g7y3p7wrua5qz6i2@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 07, 2020 at 04:47:56PM -0700, Andre Guedes wrote:
> Hi all,
> 
> This patch series adds support for parsing registers dumped by the IGC driver.
> For now, the following registers are parsed:
> 
> 	* Receive Address Low (RAL)
> 	* Receive Address High (RAH)
> 	* Receive Control (RCTL)
> 	* VLAN Priority Queue Filter (VLANPQF)
> 	* EType Queue Filter (ETQF)
> 
> More registers should be parsed as we need/enable them.
> 
> Cheers,
> Andre

Series merged. But please consider making the output consistent with
other Intel drivers which use lowercase keywords for values (e.g.
"enabled") and "yes"/"no" for bool values (rather than "True" / "False").

Michal

> 
> Andre Guedes (4):
>   Add IGC driver support
>   igc: Parse RCTL register fields
>   igc: Parse VLANPQF register fields
>   igc: Parse ETQF registers
> 
>  Makefile.am |   3 +-
>  ethtool.c   |   1 +
>  igc.c       | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  internal.h  |   3 +
>  4 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 igc.c
> 
> -- 
> 2.26.2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200720/530bffe8/attachment.asc>
