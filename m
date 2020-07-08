From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 8 Jul 2020 01:33:20 +0000
Subject: [Intel-wired-lan] [PATCH v1 2/2] igc: Add Receive Descriptor
 Minimum Threshould Count
In-Reply-To: <20200622072030.31239-1-sasha.neftin@intel.com>
References: <20200622072030.31239-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB289028F722DA9D0958871C24BC670@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, June 22, 2020 12:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 2/2] igc: Add Receive Descriptor
> Minimum Threshould Count
> 
> This register counts the number of events where the number of
> descriptors in one of the Rx queues was lower than the threshold
> defined for this queue.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
