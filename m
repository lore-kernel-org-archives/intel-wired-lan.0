From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 16 Sep 2018 13:04:07 -0700
Subject: [Intel-wired-lan] using XPS on Intel i40e
In-Reply-To: <CAGv3bDeHUA6vWen50QheqTygyDpLgTzYKLtd82amPZzK-anh_Q@mail.gmail.com>
References: <CAGv3bDeHUA6vWen50QheqTygyDpLgTzYKLtd82amPZzK-anh_Q@mail.gmail.com>
Message-ID: <CAKgT0Ufnpxp0MDXkiZ9T1jafYj_ebiTY49JOGhFwC4D+uy3YOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Sep 16, 2018 at 12:55 AM Kushal Gautam <kushal.gautam@gmail.com> wrote:
>
> Hi:
>
> I am using the Intel i40e driver from kernel source tree of Kernel 4.15.12
> My NIC is Intel X710.
>
> I am composing and sending a packet from my custom kernel module as:
>
> ...
> skb->dev->netdev_ops->ndo_start_xmit(skb, skb->dev);
> ...
>
> Just like FDIR on the receiving side, is it possible to have a similar configuration on the sending side?
>
> For instance, I want my packets sent via kernel module to pass through TX-Queue 5. Right now all my packets are being sent through just Tx-Queue 0. And maybe after that, it would make sense to use XPS(https://github.com/torvalds/linux/blob/v3.13/Documentation/networking/scaling.txt#L364)
>
> Regards,
> Kushal.

Right now you are bypassing XPS entirely if you are using
ndo_start_xmit to send you frames.

You might take a look at the pktgen code in the kernel as I believe
that has examples where they use specific queues to send packets. All
that is really involved is updating a field in the sk_buff data
structure before you call ndo_start_xmit.

Hope that helps.

- Alex
