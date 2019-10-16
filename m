From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:17:15 +0000
Subject: [Intel-wired-lan] [PATCH S31 02/15] ice: add ethtool -m support
 for reading i2c eeprom modules
In-Reply-To: <20191009140953.14087-2-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-2-anthony.l.nguyen@intel.com>
Message-ID: <e6929938c40a4954b4daa91c9c5e560a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 02/15] ice: add ethtool -m support for
> reading i2c eeprom modules
> 
> From: Scott W Taylor <scott.w.taylor@intel.com>
> 
> Implement ethtool -m support to read eeprom data from SFP/QSFP
> modules.
> 
> Signed-off-by: Scott W Taylor <scott.w.taylor@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  29 ++++
>  drivers/net/ethernet/intel/ice/ice_common.c   |  46 ++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   4 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 147 ++++++++++++++++++
>  4 files changed, 226 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


