From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Thu, 10 Dec 2020 18:10:08 +0100
Subject: [Intel-wired-lan] [PATCH net-next] ice,
 xsk: Move Rx alloction out of while-loop
In-Reply-To: <20201210161105.GD45760@ranger.igk.intel.com>
References: <20201210121915.14412-1-bjorn.topel@gmail.com>
 <20201210161105.GD45760@ranger.igk.intel.com>
Message-ID: <CAJ+HfNh4LS-25LH0gE0Pun7v=q=8zChmKUaN+hQA_58gwtbZ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 10 Dec 2020 at 17:20, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Dec 10, 2020 at 01:19:15PM +0100, Bj?rn T?pel wrote:
> > From: Bj?rn T?pel <bjorn.topel@intel.com>
> >
> > Instead of trying to allocate for each packet, move it outside the
> > while loop and try to allocate once every NAPI loop.
>
> To rectify above, it wasn't for each packet but per ICE_RX_BUF_WRITE
> cleaned frames (16).
>
> You also have a typo in subject (alloction).
>
> Is spinning a v2 worth it?
>

Sure! I'll rephrase, and resend!

Thanks,
Bj?rn
