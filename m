From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Jun 2018 23:38:16 +0300
Subject: [Intel-wired-lan] [PATCH v6 2/3] drivers core: prepare
 device_shutdown for multi-threading
In-Reply-To: <20180629182541.6735-3-pasha.tatashin@oracle.com>
References: <20180629182541.6735-1-pasha.tatashin@oracle.com>
 <20180629182541.6735-3-pasha.tatashin@oracle.com>
Message-ID: <CAHp75VdQsrxS5=Jb_+Wfu=JL0-AR1B=p8Jp3psEqH5ApmpewGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 29, 2018 at 9:25 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Do all the necessary refactoring to prepare device_shutdown() logic to
> be multi-threaded.
>
> Which includes:
> 1. Change the direction of traversing the list instead of going backward,
> we now go forward.
> 2. Children are shutdown recursively for each root device from bottom-up.
> 3. Functions that can be multi-threaded have _task() in their name.

> +/*
> + * device_children_count - device children count
> + * @parent: parent struct device.
> + *
> + * Returns number of children for this device or 0 if none.
> + */
> +static int device_children_count(struct device *parent)
> +{
> +       struct klist_iter i;
> +       int children = 0;
> +
> +       if (!parent->p)
> +               return 0;
> +
> +       klist_iter_init(&parent->p->klist_children, &i);
> +       while (next_device(&i))
> +               children++;
> +       klist_iter_exit(&i);
> +
> +       return children;
> +}

Looking at another patch in LKML (for gluedir children counting) I
would suggest to consider to cache children value.
Would it  make sense?

(So, basically you would update that value on children registered / removed)

-- 
With Best Regards,
Andy Shevchenko
