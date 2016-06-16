From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Jun 2016 08:19:18 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 05/17] bnxt: Update
 drivers to support unified UDP encapsulation offload functions
In-Reply-To: <CACKFLimVri8=L8XrgTgW_eieEwEygf4CTDZtr+wD1fE6qnrqRw@mail.gmail.com>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
 <20160615220747.15575.31433.stgit@localhost.localdomain>
 <CACKFLimVri8=L8XrgTgW_eieEwEygf4CTDZtr+wD1fE6qnrqRw@mail.gmail.com>
Message-ID: <CAKgT0UeLF3SkHTPZ7aZKUfjB9v2DCKhAsMyvtgbgH8KoWV1qXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 15, 2016 at 9:23 PM, Michael Chan <michael.chan@broadcom.com> wrote:
> On Wed, Jun 15, 2016 at 3:07 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
>> This patch ends up doing several things.  First it updates the driver to
>> make use of the new unified UDP tunnel offload notifier functions.  In
>> addition I updated the code so that we can work around the bits that were
>> checking for if VXLAN was enabled since we are now using a notifier based
>> setup.  Finally I moved the hard-coded GENEVE port over to using the
>> notifier based setup so that we can update it if needed.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>
> Looks good, except that the last item in the description above is
> actually done in the next patch.
>
> Acked-by: Michael Chan <michael.chan@broadcom.com>

Thanks for reviewing this.  I'll drop that line from the patch
description and add your Acked-by.

- Alex
