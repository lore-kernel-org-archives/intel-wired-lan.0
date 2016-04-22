From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 20:21:34 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ethtool/ixgbe: Add device ID
	and	mac_type definitions
In-Reply-To: <20160421182846.13330.65670.stgit@ixgbe-dev.jf.intel.com>
References: <20160421182545.13330.59497.stgit@ixgbe-dev.jf.intel.com>
 <20160421182846.13330.65670.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2A8D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Preethi Banala
> Sent: Thursday, April 21, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/3] ethtool/ixgbe: Add device ID and
> mac_type definitions
> 
> Add device id macro definitions, mac_type enum definition and update
> get_mac_type() accordingly.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> ---
>  ixgbe.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
driver correctly builds and changes correctly applied.
