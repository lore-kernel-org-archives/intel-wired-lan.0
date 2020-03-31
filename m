From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 20:48:11 +0000
Subject: [Intel-wired-lan] [PATCH 07/12] igc: Remove 'queue' check in
 igc_del_mac_filter()
In-Reply-To: <7d8b419b-a4e4-0222-c6b5-a6c422232ff7@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-8-andre.guedes@intel.com>
 <7d8b419b-a4e4-0222-c6b5-a6c422232ff7@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DE96@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Neftin, Sasha
> Sent: Tuesday, March 31, 2020 8:53 AM
> To: intel-wired-lan at osuosl.org; Lifshits, Vitaly <vitaly.lifshits@intel.com>; Avivi,
> Amir <amir.avivi@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH 07/12] igc: Remove 'queue' check in
> igc_del_mac_filter()
> 
> On 3/19/2020 01:00, Andre Guedes wrote:
> > igc_add_mac_filter() doesn't allow us to have more than one entry with
> > the same address and address type in adapter->mac_table so checking if
> > 'queue' matches in igc_del_mac_filter() isn't necessary. This patch
> > removes that check.
> >
> > This patch also takes the opportunity to improve the igc_del_mac_filter
> > documentation and remove comment which is not applicable to this I225
> > controller.
> >
> > Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> > ---
> >   drivers/net/ethernet/intel/igc/igc_main.c | 27 ++++++++++-------------
> >   1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> > index a71f1a5ca27c..8a3cae2367d4 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2234,14 +2234,17 @@ static int igc_add_mac_filter(struct igc_adapter
> *adapter, const u8 *addr,
> >   	return -ENOSPC;
> >   }
> >
> > -/* Remove a MAC filter for 'addr' directing matching traffic to
> > - * 'queue', 'flags' is used to indicate what kind of match need to be
> > - * removed, match is by default for the destination address, if
> > - * matching by source address is to be removed the flag
> > - * IGC_MAC_STATE_SRC_ADDR can be used.
> > - */
> > +/* Delete MAC address filter from adapter.
> > + *
> > + * @adapter: Pointer to adapter where the filter should be deleted from.
> > + * @addr: MAC address.
> > + * @flags: Set IGC_MAC_STATE_SRC_ADDR bit to indicate @address is a
> source
> > + * address.
> > + *
> > + * In case of success, returns 0. Otherwise, it returns a negative errno code.
> Block comments should align the * on each line (please, remove one space
> before *)
> > +  */ >   static int igc_del_mac_filter(struct igc_adapter *adapter, const u8
> *addr, 

Yes, that comment block throws a checkpatch warning:
-------------------
u1322:[1]/usr/src/kernels/next-queue> git format-patch $item -1 --stdout|./scripts/checkpatch.pl -
WARNING: Block comments should align the * on each line
#42: FILE: drivers/net/ethernet/intel/igc/igc_main.c:2245:
+ * In case of success, returns 0. Otherwise, it returns a negative errno code.
+  */

total: 0 errors, 1 warnings, 0 checks, 57 lines checked

Aside from that:
Tested-by: Aaron Brown <aaron.f.brown
