From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 9 Oct 2020 19:51:03 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix S0ix flow to allow
 S0i3.2 subset entry
In-Reply-To: <20200914102409.6464-1-vitaly.lifshits@intel.com>
References: <20200914102409.6464-1-vitaly.lifshits@intel.com>
Message-ID: <DM6PR11MB28907C88A5E245BE9B3543A9BC080@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Vitaly
> Lifshits
> Sent: Monday, September 14, 2020 3:24 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: fix S0ix flow to allow S0i3.2
> subset entry
> 
> Changed a configuration in the flows to align with
> architecture requirements to achieve S0i3.2 substate.
> 
> Also fixed a typo in the previous patch- e1000e: fix S0ix flows for
> cable connected case (632fbd5eb5b).
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
