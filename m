From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Thu, 15 Apr 2021 14:16:36 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210415140438.60221f21@carbon>
References: <20210415092145.27322-1-kurt@linutronix.de>
 <20210415140438.60221f21@carbon>
Message-ID: <874kg7hhej.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu Apr 15 2021, Jesper Dangaard Brouer wrote:
> On Thu, 15 Apr 2021 11:21:45 +0200
> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
>> When using native XDP with the igb driver, the XDP frame data doesn't point to
>> the beginning of the packet. It's off by 16 bytes. Everything works as expected
>> with XDP skb mode.
>> 
>> Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
>> the timestamp before executing any XDP operations and adjust all other code
>> accordingly. The igc driver does it like that as well.
>> 
>> Tested with Intel i210 card and AF_XDP sockets.
>
> Doesn't the i210 card use the igc driver?
> This change is for igb driver.

Nope. igb is for i210 and igc is for the newer Intel i225 NICs.

|01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
|[...]
|        Kernel driver in use: igb
|        Kernel modules: igb

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210415/19349a3d/attachment-0001.asc>
