From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 6 Feb 2020 17:05:40 -0800
Subject: [Intel-wired-lan] bad iperf3 tcp performance of Intel 10G NIC
 when MTU is 9000
In-Reply-To: <d8b8d4d950bf4144b1a0d2eb2e3b6656@inspur.com>
References: <79f202c9bc2fa14075d9ec9f9df86073@sslemail.net>
 <CAKgT0UeebAZ9GfQJ+EJ_mYvnoqvOYOofmGfqTkOro9x7V0c5DA@mail.gmail.com>
 <d8b8d4d950bf4144b1a0d2eb2e3b6656@inspur.com>
Message-ID: <CAKgT0UcjuE=rG0XGTqSrDQv3N6Pr50-yuG53r9fi13DZpGCToQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I haven't heard of any similar issues.

The fact that it impacts TCP only has me wondering if LRO/RSC might be
enabled on the NIC and is possibly causing issues. You might try
disabling LRO via "ethtool -k/-K" if it is enabled to see if that
resolves the issue. Beyond that the only other feature I can think of
that we might want to eliminate would be GRO. It probably wouldn't
hurt to try disabling those features on both ends and seeing if one of
them resolves the issue.

Thanks.

- Alex

On Thu, Feb 6, 2020 at 4:16 PM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
>
> Alex, thank you so much for your great suggestion. We have double checked switches, they have set jumbo frame support, we ran iperf3 to check performance, iperf3 udp is ok even if MTU is set to 9000, so we can believe no other traffic resulted in network congestion. Iperf3 tcp performance is about 8.9Gbps if MTU is set to 1500, but it is just about 3 Gbps if MTU is set to 9000. Iperf3 udp performance is about 8.9Gbps if MTU is set to 9000.
>
> I also checked the same thing in another environment, which used i40e but not ixgbe, all the cases are ok, that is why I doubt it is a kernel or driver or firmware issue, did you receive similar issue report?
>
> -----????-----
> ???: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> ????: 2020?2?7? 2:19
> ???: Yi Yang (??)-????? <yangyi01@inspur.com>
> ??: jeffrey.t.kirsher at intel.com; yang_y_yi at 163.com; intel-wired-lan at lists.osuosl.org
> ??: Re: [Intel-wired-lan] bad iperf3 tcp performance of Intel 10G NIC when MTU is 9000
>
> On Tue, Feb 4, 2020 at 7:34 AM Yi Yang (??)-????? <yangyi01@inspur.com> wrote:
> >
> > Hi, all
> >
> > We find a very weird issue on Intel 10G NIC, iperf3 tcp performance is
> > good when MTU is 1500, but it is about one third of the former when
> > MTU is 9000, anybody knows why it is so, is any solution to it available?
> >
> > The below is our kernel and ixgbe deriver information:
> >
> > Ubuntu 16.04 and kernel is updated to 4.15.0-36-generic x86_64 Ixgbe
> > driver version: 5.1.0-k Firmware version: 0x61c10001
> >
> > BTW, tso is on.
>
> There could be quite a few things going on, but it is hard to say without more information.
>
> What is the test you are running and what are the numbers you are seeing at 1500 MTU versus 9000 MTU? Have you taken a look at the "netstat -s" info on both ends to see if anything might be going on there? One possibility is if you have a congested network moving the 9K MTU frames can be slower as any 9K frames dropped will have to be retransmitted and since the frames are larger you may encounter the need for retransmit more often and they would be slower.
>
> Also have you checked the network path to make certain that you are able to send 9K frames between the two systems? If there are any switches in between not configured for 9K MTU that could cause performance issues.
>
> One debugging step you might try would be to incrementally increase the MTU size and run several tests to see if there is a certain packet size that the performance drops at. If we find the regression starts at a certain size it could point to a specific issue either in the network stack, driver, or the network itself.
>
> Thanks.
>
> - Alex
