From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:11:54 +0000
Subject: [Intel-wired-lan] [PATCH S36 7/8] ice: Implement ethtool
 get/set rx-flow-hash
In-Reply-To: <20200117153919.50321-7-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-7-anthony.l.nguyen@intel.com>
Message-ID: <c3e7307d6e3c4062afbbbc0ddc5463de@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, January 17, 2020 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S36 7/8] ice: Implement ethtool get/set rx-
> flow-hash
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> Provide support to change or retrieve RSS hash options for a flow type.
> The supported flow-types are: tcp4, tcp6, udp4, udp6, sctp4, sctp6.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 243 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.c    |  29 +++
>  drivers/net/ethernet/intel/ice/ice_flow.h    |   1 +
>  3 files changed, 273 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


