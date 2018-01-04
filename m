From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:33:24 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 13/13] i40e: fix reported
 mask for ntuple filters
In-Reply-To: <20171227132633.24272-1-alice.michael@intel.com>
References: <20171227132633.24272-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D709E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 13/13] i40e: fix reported mask
> for ntuple filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In commit 36777d9fa24c ("i40e: check current configured input set when
> adding ntuple filters") some code was added to report the input set mask for
> a given filter when reporting it to the user.
> 
> This code is necessary so that the reported filter correctly displays that it is or
> is not masking certain fields.
> 
> Unfortunately the code was incorrect. Development error accidentally
> swapped the mask values for the IPv4 addresses with the L4 port numbers.
> The port numbers are only 16bits wide while IPv4 addresses are 32 bits.
> Unfortunately we assigned only 16 bits to the IPv4 address masks.
> Additionally we assigned 32bit value 0xFFFFFFF to the TCP port numbers.
> This second part does not matter as the value would be truncated to 16bits
> regardless, but it is unnecessary.
> 
> Fix the reported masks to properly report that the entire field is masked.
> 
> Testing-hints:
>   Upstream commit message will need to reword to target the equivalent
>   upstream commit for the "Fixes" line.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


