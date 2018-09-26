From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:39:25 +0000
Subject: [Intel-wired-lan] [PATCH 4/8] ice: update fw version check logic
In-Reply-To: <20180920002311.10891-5-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
 <20180920002311.10891-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC3C7@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/8] ice: update fw version check logic
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We have MAX_FW_API_VER_BRANCH, MAX_FW_API_VER_MAJOR, and
> MAX_FW_API_VER_MINOR that we use in ice_controlq.h to test when a
> firmware version is newer than expected. This is currently tested by
> comparing each field separately. Thus, we compare the branch field against
> the MAX_FW_API_VER_BRANCH, and so forth.
> 
> This means that currently, if we suppose that the max firmware version is
> defined as 0.2.1, i.e.
> 
> #define MAX_FW_API_VER_BRANCH 0
> #define MAX_FW_API_VER_MAJOR 2
> #define MAX_FW_API_VER_MINOR 1
> 
> Then firmware 0.1.3 will fail to load. This is because the minor version
> 3 is greater than the max minor version 1.
> 
> This is not intuitive, because of the notion that increasing the major firmware
> version to 2 should mean any firmware version with a major version is less
> than 2 sould be considered older than 2...
> 
> In order to allow both 0.2.1 and 0.1.3 to load, you would have to define the
> "max" firmware version as 0.2.3.. It is possible that such a firmware version
> doesn't even exist yet!
> 
> Fix this by replacing the current logic with an updated check that behaves as
> follows:
> 
> First, we check the major version. If it is greater than the expected version,
> then we prevent driver load. Additionally, a warning message is logged to
> indicate to the system administrator that they need to update their driver.
> This is now the only case where the driver will refuse to load.
> 
> Second, if the major version is less than the expected version, we log an
> information message indicating the NVM should be updated.
> 
> Third, if the major version is exact, we'll then check the minor version. If the
> minor version is more than two versions less than expected, we log an
> information message indicating the NVM should be updated. If it is more
> than two versions greater than the expected version, we log an information
> message that the driver should be updated.
> 
> To support this, the ice_aq_ver_check function needs its signature updated
> to pass the hw structure. Since we now pass this structure, there is no need
> to pass the fw api versions separately.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 30 +++++++++++++++++----
> ------
>  1 file changed, 19 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


