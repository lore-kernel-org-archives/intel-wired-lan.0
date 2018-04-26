From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Apr 2018 09:02:26 -0700
Subject: [Intel-wired-lan] [BUG] igb: reconnecting of cable not always
 detected
In-Reply-To: <87wowumj21.fsf@gmail.com>
References: <87h8o0ocul.fsf@gmail.com>
 <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
 <877eovobxl.fsf@gmail.com>
 <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
 <87wowumj21.fsf@gmail.com>
Message-ID: <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 26, 2018 at 2:08 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> Hi,
>
>> Thanks. I'm suspecting we may need to instrument igb_rd32 at this
>> point. In order to trigger what you are seeing I am assuming the
>> device has been detached due to a read failure of some sort.
>
> Okay, I added a printk to igb_rd32. And because no one calls this
> function directly (all access goes via the rd32/rd32_array macro) I also
> added the output of the calling function. This should help greatly in
> identifying the read from the hardware to the consumer.
>
> Finally, I noticed that igb_update_stats() produced a lot of churn that
> most likely are unrelated. So I helper variable to make output from this
> function go away.
>
> I installed this modified driver, rebooted, and removed / inserted the
> LAN cable until the error was present.
>
> As before, "ethtool" and "mii-tool" now said that the device is not
> there, while "ip link" showed the device as present.
>
>
> The full output of "journalctl -fk | grep igb" is 600 kB. So put the
> whole file at Google Drive:
>
> https://drive.google.com/open?id=1p9cCT2d_EHnSHh29oS3AepUgFTKGFSeA
>
>
>
> I looked at the output to see patterns, e.g with
>
> grep -n igb_get_cfg_done_i210 igb.error.txt
> grep -n __igb_shutdown igb.error.txt
> ...
>
> (and almost all other function names). I hoped to see patterns. But for
> my untrained eye, things looked not out of the order.


Thanks for the data. It is actually useful. There are a few things
that I see that seem to point to an obvious issue.

The first are the following 2 lines from your dump:
Apr 26 10:42:49 kernel: igb 0000:02:00.0 eth0: igb: eth0 NIC Link is
Up 1000 Mbps Half Duplex, Flow Control: RX
Apr 26 10:42:49 kernel: igb 0000:02:00.0: EEE Disabled: unsupported at
half duplex. Re-enable using ethtool when at full duplex.

In case you aren't aware 1000Mbps Half Duplex is not a valid combination.

The other bit that catches my attention is:
Apr 26 10:42:51 kernel: igb 0000:02:00.0: exceed max 2 second

Which appears to be a timeout error that is triggered in response to
the above error which I believe is the fact that it didn't actually
link at 1000Mbps.

As I get time I will try to look into this further. I will have to go
through the MDIC reads to figure out if there is something in there
that is providing us with bad information from the PHY or if we are
misinterpreting something.

Thanks.

- Alex
