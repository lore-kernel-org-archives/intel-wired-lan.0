From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:37:16 +0000
Subject: [Intel-wired-lan] [PATCH S42 5/7] ice: Enable flex-bytes support
In-Reply-To: <20200512010146.41303-5-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-5-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16593FBC79F0040658C412F28CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, May 11, 2020 6:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S42 5/7] ice: Enable flex-bytes support
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Flex-bytes allows for packet matching based on an offset and value. This is
> supported via the ethtool user-def option.  It is specified by providing an
> offset followed by a 2 byte match value. Offset is measured from the start of
> the MAC address.
> 
> The following restrictions apply to flex-bytes. The specified offset must be an
> even number and be smaller than 0x1fe.
> 
> Example usage:
> 
> ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 dst-ip 172.16.0.55 \ src-port
> 12 dst-port 13 user-def 0x10ffff action 32
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  88 +++++++++-
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |   3 +
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  13 ++
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 150 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  12 ++
>  .../ethernet/intel/ice/ice_protocol_type.h    |   1 +
>  6 files changed, 265 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


