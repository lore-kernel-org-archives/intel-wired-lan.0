From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 14 Apr 2022 06:36:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] Revert "ice: Hide
 bus-info in ethtool for PRs in switchdev mode"
In-Reply-To: <20220328145828.10097-3-marcin.szycik@linux.intel.com>
References: <20220328145828.10097-1-marcin.szycik@linux.intel.com>
 <20220328145828.10097-3-marcin.szycik@linux.intel.com>
Message-ID: <DM6PR11MB454618A0BB23814F21A7ADAF9CEF9@DM6PR11MB4546.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Monday, March 28, 2022 8:28 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next 2/2] Revert "ice: Hide bus-info in
>ethtool for PRs in switchdev mode"
>
>This reverts commit bfaaba99e680bf82bf2cbf69866c3f37434ff766.
>
>Commit bfaaba99e680 ("ice: Hide bus-info in ethtool for PRs in switchdev
>mode") was a workaround for lshw tool displaying incorrect descriptions for
>port representors and PF in switchdev mode. Now the issue has been fixed in
>the lshw tool itself [1].
>
>Removing the workaround can be considered a regression, as the user might
>be running older, unpatched lshw version. However, another important
>change
>(ice: link representors to PCI device, which improves port representor netdev
>naming with SET_NETDEV_DEV) also causes the same "regression" as
>removing the workaround, i.e. unpatched lshw is able to access bus-info
>information (this time not via ethtool) and the bug can occur. Therefore, the
>workaround no longer prevents the bug and can be removed.
>
>[1] https://ezix.org/src/pkg/lshw/commit/9bf4e4c9c1
>
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
