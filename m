From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Apr 2015 05:59:41 -0700
Subject: [Intel-wired-lan] [PATCH v2 0/3] RSS fix for ixgbe/ixgbevf
In-Reply-To: <1430276261-29821-1-git-send-email-fan.du@intel.com>
References: <1430276261-29821-1-git-send-email-fan.du@intel.com>
Message-ID: <1430398781.2669.110.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-29 at 10:57 +0800, Fan Du wrote:
> This patchset provides RSS hash value for upper stack by indicating
> whether it's a L3 or L4 hash. Thus other component of network
> stack could utilize this hash value provided by NIC without caculating
> by themselves.
> 
> Test:
> * Simple iperf test using ixgbe for 82599ES
> * Build test only for ixgbevf
> * make C=1 CF=-D__CHECK_ENDIAN__, no warnings introduced by this patchset
> 
> Changelog:
> v2:
>   - Add patch3 to make all hash value from RSS part.
> v1:
>   - Code style issue suggeted by Tantilov, Emil S.
>   - Initial version
> 
> Fan Du (3):
>   ixgbe: Specify rx hash type wrt rx desc RSS type
>   ixgbevf: Set rx hash type for ingress packets
>   ixgbe: Don't report flow director filter's status
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c    |    2 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   25 ++++++++++++++++---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27 +++++++++++++++++++++
>  4 files changed, 60 insertions(+), 6 deletions(-)
> 

Thanks Fan, I have added your series to my queue for further review and
testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150430/7731aa3f/attachment.asc>
