From: Gomonovych, Vasyl <gomonovych@gmail.com>
Date: Fri, 13 Dec 2019 13:25:20 +0200
Subject: [Intel-wired-lan] [PATCH] igb: index regs_buff array via index
 variable
In-Reply-To: <CAKgT0UeTgGmQGEaJ3ePmCoEW5r5KDMmE0c0jrBGGeb-uzbq=3A@mail.gmail.com>
References: <20191212105847.16488-1-gomonovych@gmail.com>
 <CAKgT0UeTgGmQGEaJ3ePmCoEW5r5KDMmE0c0jrBGGeb-uzbq=3A@mail.gmail.com>
Message-ID: <CAHYXAn+0VG_dnRt5W-kxKsZoy3wwt7MibinMQrSP5wUUpXQCww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ok, thanks for the clarification.

On Fri, 13 Dec 2019, 02:49 Alexander Duyck, <alexander.duyck@gmail.com>
wrote:

> On Thu, Dec 12, 2019 at 2:58 AM Vasyl Gomonovych <gomonovych@gmail.com>
> wrote:
> >
> > This patch is just a preparation for additional register dump in
> regs_buff.
> > To make new register insertion in the middle of regs_buff array easier
> > change array indexing to use local counter reg_ix.
> >
> > ---
> >
> > Basically this path is just a subject to ask
> > How to add a new register to dump from dataseet
> > Because it is logically better to add an additional register
> > in the middle of an array but that will break ABI.
> > To not have the ABI problem we should just add it at the
> > end of the array and increase the array size.
>
> So I am pretty sure the patch probably breaks ABI. The reasons for the
> fixed offsets is because this driver supports multiple parts that have
> different register sets so we cannot have them overlapping.
>
> We cannot change the register locations because it will break the
> interface with ethtool. If you need to add additional registers you
> will need to add them to the end of the array.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191213/5b4d6453/attachment-0001.html>
