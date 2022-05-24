From: Olivier Matz <olivier.matz@6wind.com>
Date: Tue, 24 May 2022 09:37:52 +0200
Subject: [Intel-wired-lan] [PATCH net v2 0/2] ixgbe: fix promiscuous
 mode on VF
In-Reply-To: <YmaLWN0aGIKCzkHP@platinum>
References: <20220406095252.22338-1-olivier.matz@6wind.com>
 <YmaLWN0aGIKCzkHP@platinum>
Message-ID: <YoyLUEk9n1uXHscH@platinum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On Mon, Apr 25, 2022 at 01:51:53PM +0200, Olivier Matz wrote:
> Hi,
> 
> On Wed, Apr 06, 2022 at 11:52:50AM +0200, Olivier Matz wrote:
> > These 2 patches fix issues related to the promiscuous mode on VF.
> > 
> > Comments are welcome,
> > Olivier
> > 
> > Cc: stable at vger.kernel.org
> > Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> > 
> > Changes since v1:
> > - resend with CC intel-wired-lan
> > - remove CC Hiroshi Shimamoto (address does not exist anymore)
> > 
> > Olivier Matz (2):
> >   ixgbe: fix bcast packets Rx on VF after promisc removal
> >   ixgbe: fix unexpected VLAN Rx in promisc mode on VF
> > 
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Any feedback about this patchset?
> Comments are welcome.

I didn't get feedback for this patchset until now. Am I doing things
correctly? Am I targeting the appropriate mailing lists and people?

Please let me know if I missed something.

Thanks,
Olivier
