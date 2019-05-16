From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 May 2019 10:10:55 -0700
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <20190514163443.glfjva3ofqcy7lbg@csclub.uwaterloo.ca>
References: <20190502171636.3yquioe3gcwsxlus@csclub.uwaterloo.ca>
 <CAKgT0Ufk8LXMb9vVWfvgbjbQFKAuenncf95pfkA0P1t-3+Ni_g@mail.gmail.com>
 <20190502175513.ei7kjug3az6fe753@csclub.uwaterloo.ca>
 <20190502185250.vlsainugtn6zjd6p@csclub.uwaterloo.ca>
 <CAKgT0Uc_YVzns+26-TL+hhmErqG4_w4evRqLCaa=7nME7Zq+Vg@mail.gmail.com>
 <20190503151421.akvmu77lghxcouni@csclub.uwaterloo.ca>
 <CAKgT0UcV2wCr6iUYktZ+Bju_GNpXKzR=M+NLfKhUsw4bsJSiyA@mail.gmail.com>
 <20190503205935.bg45rsso5jjj3gnx@csclub.uwaterloo.ca>
 <20190513165547.alkkgcsdelaznw6v@csclub.uwaterloo.ca>
 <CAKgT0Uf_nqZtCnHmC=-oDFz-3PuSM6=30BvJSDiAgzK062OY6w@mail.gmail.com>
 <20190514163443.glfjva3ofqcy7lbg@csclub.uwaterloo.ca>
Message-ID: <CAKgT0UdPDyCBsShQVwwE5C8fBKkMcfS6_S5m3T7JP-So9fzVgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 14, 2019 at 9:34 AM Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
>
> On Mon, May 13, 2019 at 12:04:00PM -0700, Alexander Duyck wrote:
> > So I recreated the first packet you listed via text2pcap, replayed it
> > on my test system via tcpreplay, updated my configuration to 12
> > queues, and used the 2 hash keys you listed. I ended up seeing the
> > traffic bounce between queues 4 and 8 with an X710 I had to test with
> > when I was changing the key value.
> >
> > Unfortunately I don't have an X722 to test with. I'm suspecting that
> > there may be some difference in the RSS setup, specifically it seems
> > like values in the PFQF_HENA register were changed for the X722 part
> > that may be causing the issues we are seeing.
> >
> > I will see if I can get someone from the networking division to take a
> > look at this since I don't have access to the part in question nor a
> > datasheet for it so I am not sure if I can help much more.
>
> Great.  I hope someone can figure this out because it is working very
> badly so far.
>
> --
> Len Sorensen

So I was sent a link to the datasheet for the part and I have a
working theory that what we may be seeing is a problem in the firmware
for the part.

Can you try applying the attached patch and send the output from the
dmesg? Specifically I would want anything with the name "i40e" in it.
What I am looking for is something like the following:
[  294.383416] i40e 0000:81:00.1: fw 5.0.40043 api 1.5 nvm 5.04 0x800024cd 0.0.0
[  294.675039] i40e 0000:81:00.1: MAC address: 68:05:ca:37:c7:99
[  294.685941] i40e 0000:81:00.1: flow_type: 63 input_mask:0x0000000000004000
[  294.686056] i40e 0000:81:00.1: flow_type: 46 input_mask:0x0007fff800000000
[  294.686170] i40e 0000:81:00.1: flow_type: 45 input_mask:0x0007fff800000000
[  294.686284] i40e 0000:81:00.1: flow_type: 44 input_mask:0x0007ffff80000000
[  294.686399] i40e 0000:81:00.1: flow_type: 43 input_mask:0x0007fffe00000000
[  294.686513] i40e 0000:81:00.1: flow_type: 41 input_mask:0x0007fffe00000000
[  294.686628] i40e 0000:81:00.1: flow_type: 36 input_mask:0x0001801800000000
[  294.686743] i40e 0000:81:00.1: flow_type: 35 input_mask:0x0001801800000000
[  294.686858] i40e 0000:81:00.1: flow_type: 34 input_mask:0x0001801f80000000
[  294.686973] i40e 0000:81:00.1: flow_type: 33 input_mask:0x0001801e00000000
[  294.687087] i40e 0000:81:00.1: flow_type: 31 input_mask:0x0001801e00000000
[  294.691906] i40e 0000:81:00.1 ens5f1: renamed from eth0
[  294.711173] i40e 0000:81:00.1 ens5f1: NIC Link is Up, 10 Gbps Full
Duplex, Flow Control: None
[  294.759061] i40e 0000:81:00.1: PCI-Express: Speed 8.0GT/s Width x8
[  294.863363] i40e 0000:81:00.1: Features: PF-id[1] VFs: 32 VSIs: 34
QP: 32 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA

With that we can tell what flow types are enabled, and what input
fields are enabled for each flow type. My suspicion is that we may see
the two new types added to X722 for UDP, 29 and 30, may not match type
31 which is the current flow type supported on the X710.

I have included a copy inline below in case the patch is stripped,
however I suspect it will not apply cleanly as the mail client I am
using usually ends up causing white space mangling by replacing tabs
with spaces.

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 65c2b9d2652b..0c93859f8184 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10998,6 +10998,15 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
                ((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
        hena |= i40e_pf_get_default_rss_hena(pf);

+       for (ret = 64; ret--;) {
+               if (!(hena & (1ull << ret)))
+                       continue;
+               dev_info(&pf->pdev->dev, "flow_type: %d
input_mask:0x%08x%08x\n",
+                        ret,
+                        i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, ret)),
+                        i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, ret)));
+       }
+
        i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
        i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), (u32)(hena >> 32));
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i40e-debug-hash-inputs.patch
Type: text/x-patch
Size: 999 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190516/5c260154/attachment.bin>
