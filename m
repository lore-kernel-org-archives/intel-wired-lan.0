From: JD <jdtxs00@gmail.com>
Date: Sun, 1 Nov 2020 21:48:18 -0600
Subject: [Intel-wired-lan] i40e/iavf bandwidth spikes to 500Gbps &
 returning IAVF_ERR_PARAM
In-Reply-To: <DM6PR11MB4657C3917162CED4AD9377769B130@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <CAMnf+PhD9VJH-db8nssDr9RgyJY6JV7bBL-Yvn2U87gSxfp+mg@mail.gmail.com>
 <DM6PR11MB4657C3917162CED4AD9377769B130@DM6PR11MB4657.namprd11.prod.outlook.com>
Message-ID: <CAMnf+PgOmUX8QPXNiiQoYxyHW6vTLbsBL+Orb_-MzpY=oXdZpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Arkadiusz, I suppose that makes sense. I didn't expect VF/PF
communication issues to increment bandwidth counters in /proc/net/dev
(which Prom reads).

I will get the i40e driver upgraded and hopefully the problem will go away
for good.

Thank you very much for the reply, much appreciated!

On Sun, Nov 1, 2020 at 1:35 PM Kubalewski, Arkadiusz <
arkadiusz.kubalewski@intel.com> wrote:

> Good day JD!
>
> The message you have provided:
> iavf 0000:00:05.0: PF returned error -5 (IAVF_ERR_PARAM) to our request 15
> indicates that there was a failure while communicating with parent PF port.
> In fact, failed command was trying to get statistics of a VF port from
> parent PF.
> Command have failed, so the stats returned shall be equal to 0.
> Probably Prometheus considered them valid and that is why it shows
> "impossible" stats.
>
> About the command failure...
> It is related to old issue, where PF and VF are out of sync on their
> communication channel.
>
> The issue was already fixed in 2.12.6, please use the latest driver to get
> rid of the issue
>
> Hope this helps ?
>
> Best Regards,
>
> Arkadiusz Kubalewski
> Software Engineer
> CG EPG SW ITP Linux base driver
>
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of JD
> Sent: pi?tek, 30 pa?dziernika 2020 18:33
> To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] i40e/iavf bandwidth spikes to 500Gbps &
> returning IAVF_ERR_PARAM
>
> Hello,
>
> Over the past month I've observed some KVM servers exhibiting extremely
> high bandwidth activity (500gbit, which is impossible).
> Please see the attached graphs from Prometheus. It starts small then
> progressively gets worse over time.
>
> During these spikes, I see the following appear on the KVM guest about
> once every minute.
> iavf 0000:00:05.0: PF returned error -5 (IAVF_ERR_PARAM) to our request 15
>
> And on the KVM parent, I see this about once every minute:
> i40e 0000:81:00.0: VF 20 failed opcode 15, retval: -5
>
> This doesn't seem to happen with any obvious cause, the only other thing I
> see in dmesg that may be related is the following (which is repeated a few
> times over several hours, but not at the same rate)
>
> vfio-pci 0000:81:0c.3: Event logged [IO_PAGE_FAULT domain=0x0000
> address=0xfffffffdf8040000 flags=0x0008]
>
>
> The KVM guest is running the iavf driver:
> driver: iavf
> version: 3.9.3
>
> The KVM parent is running the i40e driver:
> driver: i40e
> version: 2.11.21
>
> I'm running 2 of the following NIC's on the KVM parent in a bonded setup
> (mode 4, hash policy 3+4, IEEE 802.3ad dynamic link aggregation)
> :
> Intel Corporation Ethernet Controller XXV710 for 25GbE SFP28 (rev 02)
>
> Both the parent/guest are running the same kernel version of 4.19.107
>
> I'm not sure whether this is a NIC issue, driver issue, or something else.
> I'm happy to provide any more information about the system on request if it
> is relevant (qemu versions, mobo/cpu/ram).  I've observed this issue on 3
> different KVM parents/guests in different regions.
>
> If this has already been fixed or is a known issue, then I apologize, but
> I could not find anything by searching the mailing list w/ my codes from
> dmesg.
>
> If anyone can provide any information about this or any pointers on this
> or how to narrow the issue down, I'd greatly appreciate it.
>
> Thank you.
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia
> Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 |
> Kapita zakadowy 200.000 PLN.
> Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i
> moe zawiera informacje poufne. W razie przypadkowego otrzymania tej
> wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie;
> jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the
> sole use of the intended recipient(s). If you are not the intended
> recipient, please contact the sender and delete all copies; any review or
> distribution by others is strictly prohibited.
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201101/951fa49f/attachment.html>
