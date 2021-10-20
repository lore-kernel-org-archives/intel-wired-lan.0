From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Wed, 20 Oct 2021 11:08:11 -0700
Subject: [Intel-wired-lan] [PATCH linux-next] e1000: Remove redundant
 statement
In-Reply-To: <20211020092537.GF3935@kernel.org>
References: <20211018085305.853996-1-luo.penghao@zte.com.cn>
 <20211020092537.GF3935@kernel.org>
Message-ID: <CAEuXFEzXSU-Ws6T_8TBVfgskh4VA14LmirFYSjdQpwtndfeeww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Apologies for the duplicates, mail from my intel account going out
through outlook.com is not being delivered.

On Wed, Oct 20, 2021 at 7:00 AM Simon Horman <horms@kernel.org> wrote:

> > Value stored to 'ctrl_reg' is never read.
>
> I agree this does seem to be the case.
>
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the review, but (davem/kuba) please do not apply.

> > @@ -1215,8 +1215,6 @@ static int e1000_integrated_phy_loopback(struct e1000_adapter *adapter)
> >               e1000_write_phy_reg(hw, PHY_CTRL, 0x8140);
> >       }
> >
> > -     ctrl_reg = er32(CTRL);

Thanks for your patch, but this change is not safe. you're removing a
read that could do two things. The first is that the read "flushes"
the write just above to PCI (it's a PCI barrier), and the second is
that the read can have some side effects.

If this change must be done, the code should be to remove the
assignment to ctrl_reg, but leave the read, so the line would just
look like:
        er32(CTRL);

This will get rid of the warning and not change the flow from the
hardware perspective.

> > -
> >       /* force 1000, set loopback */
> >       e1000_write_phy_reg(hw, PHY_CTRL, 0x4140);
> >

Please do not apply this.
