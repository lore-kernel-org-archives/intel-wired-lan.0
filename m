From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 00:21:55 +0000
Subject: [Intel-wired-lan] [PATCH 0/3] igb, ixgbe,
 i40e UDP segmentation offload support
In-Reply-To: <0e0e706c-4ce9-c27a-af55-339b4eb6d524@akamai.com>
References: <1570658777-13459-1-git-send-email-johunt@akamai.com>
 <CAKgT0UdBPYRnwAuOGhCBAJSRhdHcnw28Tznr0GPAtqe-JWFjTQ@mail.gmail.com>
 <cd8ac880-61fe-b064-6271-993e8c6eee65@akamai.com>
 <CAKgT0UfXgzur2TGv1dNw0PQXAP0C=bNoJY6gnthASeQrHr66AA@mail.gmail.com>
 <0e0e706c-4ce9-c27a-af55-339b4eb6d524@akamai.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C727@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Adding Andrew as he is most likely going to be testing this patch.

Unfortunately my mail server flags attached scripts as potential threats and strips them out.  Can you resent it as an tar file?  I don't believe it's smart enough to open up tar and flag it as a script.

> -----Original Message-----
> From: Josh Hunt [mailto:johunt at akamai.com]
> Sent: Thursday, October 10, 2019 5:08 PM
> To: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Netdev <netdev@vger.kernel.org>; Willem de Bruijn
> <willemb@google.com>; intel-wired-lan <intel-wired-lan@lists.osuosl.org>;
> Brown, Aaron F <aaron.f.brown@intel.com>
> Subject: Re: [PATCH 0/3] igb, ixgbe, i40e UDP segmentation offload support
> 
> On 10/10/19 2:32 PM, Alexander Duyck wrote:
> > On Thu, Oct 10, 2019 at 2:17 PM Josh Hunt <johunt@akamai.com> wrote:
> >>
> >> On 10/9/19 3:44 PM, Alexander Duyck wrote:
> >>> On Wed, Oct 9, 2019 at 3:08 PM Josh Hunt <johunt@akamai.com> wrote:
> >>>>
> >>>> Alexander Duyck posted a series in 2018 proposing adding UDP
> segmentation
> >>>> offload support to ixgbe and ixgbevf, but those patches were never
> >>>> accepted:
> >>>>
> >>>>
> https://lore.kernel.org/netdev/20180504003556.4769.11407.stgit at localhost.lo
> caldomain/
> >>>>
> >>>> This series is a repost of his ixgbe patch along with a similar
> >>>> change to the igb and i40e drivers. Testing using the udpgso_bench_tx
> >>>> benchmark shows a noticeable performance improvement with these
> changes
> >>>> applied.
> >>>>
> >>>> All #s below were run with:
> >>>> udpgso_bench_tx -C 1 -4 -D 172.25.43.133 -z -l 30 -u -S 0 -s $pkt_size
> >>>>
> >>>> igb::
> >>>>
> >>>> SW GSO (ethtool -K eth0 tx-udp-segmentation off):
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            120143.64       113     81263   81263   83.55   1.35
> >>>> 2944            120160.09       114     40638   40638   62.88   1.81
> >>>> 5888            120160.64       114     20319   20319   43.59   2.61
> >>>> 11776           120160.76       114     10160   10160   37.52   3.03
> >>>> 23552           120159.25       114     5080    5080    34.75   3.28
> >>>> 47104           120160.55       114     2540    2540    32.83   3.47
> >>>> 61824           120160.56       114     1935    1935    32.09   3.55
> >>>>
> >>>> HW GSO offload (ethtool -K eth0 tx-udp-segmentation on):
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            120144.65       113     81264   81264   83.03   1.36
> >>>> 2944            120161.56       114     40638   40638   41      2.78
> >>>> 5888            120160.23       114     20319   20319   23.76   4.79
> >>>> 11776           120161.16       114     10160   10160   15.82   7.20
> >>>> 23552           120156.45       114     5079    5079    12.8    8.90
> >>>> 47104           120159.33       114     2540    2540    8.82    12.92
> >>>> 61824           120158.43       114     1935    1935    8.24    13.83
> >>>>
> >>>> ixgbe::
> >>>> SW GSO:
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            1070565.90      1015    724112  724112  100     10.15
> >>>> 2944            1201579.19      1140    406342  406342  95.69   11.91
> >>>> 5888            1201217.55      1140    203185  203185  55.38   20.58
> >>>> 11776           1201613.49      1140    101588  101588  42.15   27.04
> >>>> 23552           1201631.32      1140    50795   50795   35.97   31.69
> >>>> 47104           1201626.38      1140    25397   25397   33.51   34.01
> >>>> 61824           1201625.52      1140    19350   19350   32.83   34.72
> >>>>
> >>>> HW GSO Offload:
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            1058681.25      1004    715954  715954  100     10.04
> >>>> 2944            1201730.86      1134    404254  404254  61.28   18.50
> >>>> 5888            1201776.61      1131    201608  201608  30.25   37.38
> >>>> 11776           1201795.90      1130    100676  100676  16.63   67.94
> >>>> 23552           1201807.90      1129    50304   50304   10.07   112.11
> >>>> 47104           1201748.35      1128    25143   25143   6.8     165.88
> >>>> 61824           1200770.45      1128    19140   19140   5.38    209.66
> >>>>
> >>>> i40e::
> >>>> SW GSO:
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            650122.83       616     439362  439362  100     6.16
> >>>> 2944            943993.53       895     319042  319042  100     8.95
> >>>> 5888            1199751.90      1138    202857  202857  82.51   13.79
> >>>> 11776           1200288.08      1139    101477  101477  64.34   17.70
> >>>> 23552           1201596.56      1140    50793   50793   59.74   19.08
> >>>> 47104           1201597.98      1140    25396   25396   56.31   20.24
> >>>> 61824           1201610.43      1140    19350   19350   55.48   20.54
> >>>>
> >>>> HW GSO offload:
> >>>> $pkt_size       kB/s(sar)       MB/s    Calls/s Msg/s   CPU     MB2CPU
> >>>>
> =================================================================
> =======
> >>>> 1472            657424.83       623     444653  444653  100     6.23
> >>>> 2944            1201242.87      1139    406226  406226  91.45   12.45
> >>>> 5888            1201739.95      1140    203199  203199  57.46   19.83
> >>>> 11776           1201557.36      1140    101584  101584  36.83   30.95
> >>>> 23552           1201525.17      1140    50790   50790   23.86   47.77
> >>>> 47104           1201514.54      1140    25394   25394   17.45   65.32
> >>>> 61824           1201478.91      1140    19348   19348   14.79   77.07
> >>>>
> >>>> I was not sure how to proper attribute Alexander on the ixgbe patch so
> >>>> please adjust this as necessary.
> >>>
> >>> For the ixgbe patch I would be good with:
> >>> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>
> >>> The big hurdle for this will be validation. I know that there are some
> >>> parts such as the 82598 in the case of the ixgbe driver or 82575 in
> >>> the case of igb that didn't support the feature, and I wasn't sure
> >>> about the parts supported by i40e either.  From what I can tell the
> >>> x710 datasheet seems to indicate that it is supported, and you were
> >>> able to get it working with your patch based on the numbers above. So
> >>> that just leaves validation of the x722 and making sure there isn't
> >>> anything firmware-wise on the i40e parts that may cause any issues.
> >>
> >> Thanks for feedback Alex.
> >>
> >> For validation, I will look around and see if we have any of the above
> >> chips in our testbeds. The above #s are from i210, 82599ES, and x710
> >> respectively. I'm happy to share my wrapper script for the gso selftest
> >> if others have the missing chipsets and can verify.
> >>
> >> Thanks!
> >> Josh
> >
> > If you could share your test scripts that would be great. I believe
> > the networking division will have access to more hardware so if you
> > could include Aaron, who I added to the Cc, in your reply with the
> > script that would be great as I am sure he can forward it on to
> > whoever ends up having to ultimately test this patch set.
> >
> > I'll keep an eye out for v2 of your patch set and review it when it is
> > available.
> >
> > Thanks.
> >
> > - Alex
> >
> 
> I've attached my benchmark wrapper script udpgso_bench.sh. To run it
> you'll need to copy it, udpgso_bench_rx, and udpgso_bench_tx (built from
> kernel's selftests dir) to your DUT. It also requires a remote sink
> machine able to receive traffic on UDP 8000 (or some configured port.)
> The script will copy over and start the sink process (udpgso_bench_rx)
> on the remote box.
> 
> Here's some info on how to run it:
> 
> Usage: ./udpgso_bench.sh <interface name> <remote v4 IP> [extra
> benchmark options]
> 
> Example usage:
> # ./udpgso_bench.sh eth0 172.25.43.133 -u
> 
> Beware it will make some configuration changes to your local machine. It
> will overwrite:
>   * /proc/sys/net/core/{optmem_max,wmem_max,wmem_default}
>   * qdisc setup for <int>
>   * IRQ affinity and XPS configuration for <int>
> 
> Please let me know if you hit any problems with the script. It
> originally had some akamai-specific items in it, but I (hopefully) have
> removed them all.
> 
> Josh
