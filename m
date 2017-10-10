From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:38:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 01/14 net-next] i40e: rename
	'cmd'	variables in ethtool interface
In-Reply-To: <20171005215344.2886-2-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-2-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC241@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Thursday, October 5, 2017 2:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 01/14 net-next] i40e: rename 'cmd'
> variables in ethtool interface
> 
> After the switch to the new ethtool API, ethtool passes us ethtool_ksettings
> structs instead of ethtool_command structs, however we were still referring
> to them as 'cmd' variables.  This renames them to 'ks' variables which makes
> the code easier to understand.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 139 +++++++++++++-------
> -----
>  1 file changed, 70 insertions(+), 69 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


