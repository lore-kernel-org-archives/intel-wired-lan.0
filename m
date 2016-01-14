From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:17:56 +0000
Subject: [Intel-wired-lan] [next PATCH 11/11] igb: Add workaround for
 VLAN tag stripping on 82576
In-Reply-To: <20160107071143.13648.51160.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071143.13648.51160.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F1BE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 11/11] igb: Add workaround for VLAN tag stripping on 82576
> 
> There was a workaround partially implemented for the 82576 that is needed
> in order for VLAN tag stripping to function correctly.  The original code
> had side effects that would make it so the workaround was active on all
> MACs.  I have updated the code so that the workaround is enabled, but
> limited to the 82576, or activated if we exceed the available unicast
> addresses.
> 
> The workaround has a side effect of mirroring all of the traffic outgoing
> from the VFs back to the PF.  As such it is not recommended to use the
> 82576 in promiscuous mode as it will take a performance hit, though this is
> now consistent with the performance as seen on the out-of-tree igb driver.
> 
> I also limited the scope of the UTA bits all being set to only when the
> VMOLR register is enabled.  This should limit the effects of the UTA
> register so that we don't pick up any excess traffic unless promiscuous mode
> has been enabled on the PF, whereas before the PF would have ended up in
> something equivalent to unicast promiscuous mode with VLAN filtering
> otherwise.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c |    2 ++
>  drivers/net/ethernet/intel/igb/igb_main.c    |   26 ++++++++++++++------------
>  2 files changed, 16 insertions(+), 12 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
