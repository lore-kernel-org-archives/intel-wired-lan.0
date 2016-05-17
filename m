From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:41:29 +0000
Subject: [Intel-wired-lan] [next PATCH S37 06/15] i40evf: don't
	overflow	buffer
In-Reply-To: <1463419605-30746-7-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D6890@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 06/15] i40evf: don't overflow
> buffer
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the user adds an obscene amount of MAC addresses, the driver will run
> into the situation where it has too many address requests to fit into a single
> PF message. The driver checks for this case, and calculates the maximum
> number of messages that it can send. Then it completely ignores this count
> and overflows the buffer.
> 
> Fix this by checking the address count and bailing out of the loop at the
> appropriate time.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: If8dcbb04602c75941dc0cd8309065e1de9ca791c
> ---
> Testing Hints : Add a thousand filters as quickly as possible.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Successfully added 1000 MACs without error or overflow

