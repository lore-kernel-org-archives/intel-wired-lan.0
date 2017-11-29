From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Nov 2017 04:07:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igb: Clarify idleslope
 config constraints
In-Reply-To: <20171110222150.17754-1-jesus.sanchez-palencia@intel.com>
References: <20171110222150.17754-1-jesus.sanchez-palencia@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6F27B9@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jesus Sanchez-Palencia
> Sent: Friday, November 10, 2017 2:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sanchez-Palencia, Jesus <jesus.sanchez-palencia@intel.com>; Guedes,
> Andre <andre.guedes@intel.com>; Briano, Ivan <ivan.briano@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next] igb: Clarify idleslope config
> constraints
> 
> By design, the idleslope increments are restricted to 16.384kbps steps.
> Add a comment to igb_main.c making that explicit and add one example
> that illustrates the impact of that.
> 
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
