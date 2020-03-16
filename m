From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 16 Mar 2020 19:15:39 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/9] ice: use __le16 types for
 explicitly Little Endian values
In-Reply-To: <20200312015818.1007882-2-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-2-jacob.e.keller@intel.com>
Message-ID: <1866427914e247048105464443d19822@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jacob Keller
Sent: Wednesday, March 11, 2020 6:58 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [Intel-wired-lan] [PATCH v3 1/9] ice: use __le16 types for explicitly Little Endian values

The ice_read_sr_aq function returns words in the Little Endian format.
Remove the need for __force and typecasting by using a local variable in the ice_read_sr_word_aq function.

Additionally clarify explicitly that the ice_read_sr_aq function takes storage for __le16 values instead of using u16.

Being explicit about the endianness of this data helps when using tools like sparse to catch endian-related issues.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


