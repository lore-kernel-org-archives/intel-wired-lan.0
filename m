From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 14 Mar 2016 12:20:26 -0700
Subject: [Intel-wired-lan] [PATCH v2 net-next] ixgbe: Avoid unaligned
 access in ixgbe_atr() for LLC packets
In-Reply-To: <20160314175909.GH5084@oracle.com>
References: <20160314174624.GG5084@oracle.com>
 <CAKgT0Ucnf7Yyzjp_vccimVmjx-ZbYnOfKoTt6rEEZOsOEhVboQ@mail.gmail.com>
 <20160314175909.GH5084@oracle.com>
Message-ID: <CAKgT0Ud9b7MaOk-O4gs3LCMgO+dApCFJ=tOrStk1kuxEE5dShw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 14, 2016 at 10:59 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (03/14/16 10:55), Alexander Duyck wrote:
>>
>> One other thing I forgot to mention is that we don't support ARP so
>> that check could be dropped.  The ATR code only supports IPv4 or IPv6
>> with TCP.
>
> I did notice that, but I left it in place because (a) it comes down
> the stack with the NET_IP_ALIGNment and (b) ARP is only sent over
> Ethernet II (there is no LLC SAP for ARP, which is a big reason
> why ipv4 is not sent over llc, despite rfc 1042).
>
> I figured it would not hurt to pass it down, in case we decide
> to do something clever with it in the future.

I figure it is better to just drop it since we don't need to be trying
to parse ARP packets anyway.

- Alex
