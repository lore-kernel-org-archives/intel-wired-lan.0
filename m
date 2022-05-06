From: Maximilian Heyne <mheyne@amazon.de>
Date: Fri, 6 May 2022 06:44:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] drivers,
 ixgbe: show VF statistics
In-Reply-To: <20220504201632.2a41a3b9@kernel.org>
Message-ID: <20220506064440.57940-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2022-05-04T20:16:32-07:00   Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 3 May 2022 15:00:17 +0000 Maximilian Heyne wrote:
> > +		for (i = 0; i < adapter->num_vfs; i++) {
> > +			ethtool_sprintf(&p, "VF %u Rx Packets", i);
> > +			ethtool_sprintf(&p, "VF %u Rx Bytes", i);
> > +			ethtool_sprintf(&p, "VF %u Tx Packets", i);
> > +			ethtool_sprintf(&p, "VF %u Tx Bytes", i);
> > +			ethtool_sprintf(&p, "VF %u MC Packets", i);
> > +		}
> 
> Please drop the ethtool stats. We've been trying to avoid duplicating
> the same stats in ethtool and iproute2 for a while now.
> 

I can see the point that standard metrics should only be reported via the
iproute2 interface. However, in this special case this patch was intended to
converge the out-of-tree driver with the in-tree version. These missing stats
were breaking our userspace. If we now switch solely to iproute2 based
statistics both driver versions would diverge even more. So depending on where a
user gets the ixgbe driver from, they have to work-around.

I can change the patch as requested, but it will contradict the inital
intention. At least Intel should then port this change to the external driver as
well. Let's get a statement from them.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



