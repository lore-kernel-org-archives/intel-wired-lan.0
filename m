From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Mar 2019 17:44:36 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: fix i40e_ptp_adjtime when given
 a negative delta
In-Reply-To: <CAK8P3a3gDmbUBAK2oq22rArD5Eou_6irduMNst+jM-7_kw7Dzg@mail.gmail.com>
References: <20190225192005.3233-1-jacob.e.keller@intel.com>
 <CAK8P3a3gDmbUBAK2oq22rArD5Eou_6irduMNst+jM-7_kw7Dzg@mail.gmail.com>
Message-ID: <CAK8P3a0vozSXboQan+ifExAMo0Ag=T-kAvAX3QC9adDDQ+COzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 25, 2019 at 8:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 25, 2019 at 8:20 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >
> > Commit 0ac30ce43323 ("i40e: fix up 32 bit timespec references",
> > 2017-07-26) claims to be cleaning up references to 32-bit timespecs.
> >
> > The actual contents of the commit make no sense, as it converts a call
> > to timespec64_add into timespec64_add_ns. This would seem ok, if (a) the
> > change was documented in the commit message, and (b) timespec64_add_ns
> > supported negative numbers.
> >
> > timespec64_add_ns doesn't work with signed deltas, because the
> > implementation is based around iter_div_u64_rem. This change resulted in
> > a regression where i40e_ptp_adjtime would interpret small negative
> > adjustments as large positive additions, resulting in incorrect
> > behavior.
> >
> > This commit doesn't appear to fix anything, is not well explained, and
> > introduces a bug, so lets just revert it.
>
> Ah, this is not the bug I was referring to but actually worse.
> I was only worried about hogging the CPU while doing billions
> of additions in a loop, and had not realized it also changes
> the result.
>
> > Reverts: 0ac30ce43323 ("i40e: fix up 32 bit timespec references", 2017-07-26)
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Any update on this? Your patch doesn't seem to have made it in as
a bugfix, or into linux-next yet.

       Arnd
