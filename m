From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:37:02 +0000
Subject: [Intel-wired-lan] [PATCH S10 05/15] ice: Implement support for
 normal get_eeprom[_len] ethtool ops
In-Reply-To: <20181219180334.1104-6-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A19@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 05/15] ice: Implement support for
> normal get_eeprom[_len] ethtool ops
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Add support for get_eeprom and get_eeprom_len ethtool ops
> 
> Specification states that PF software accesses NVM (shadow-ram) via AQ
> commands (e.g. NVM Read, NVM Write) in the range 0x000000-0x00FFFF
> (64KB), so the get_eeprom_len op should return 64KB.  If additional regions
> of the 16MB NVM must be read, another access method must be used.
> 
> The ethtool kernel code, by default, will ask for multiple page-size hunks of
> the NVM not to exceed the value returned by ice_get_eeprom_len().
> ice_read_sr_buf() deals with arch page sizes different than 4KB.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_common.h  |  2 +
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 51 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_nvm.c     | 81
> ++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
