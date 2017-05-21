From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 May 2017 15:35:13 -0700
Subject: [Intel-wired-lan] [PATCH 0/4] Configuring traffic classes via
 new hardware offload mechanism in tc/mqprio
In-Reply-To: <CAJ3xEMjTDW7sQ5CFmTyR5xMpin_WFFQg-S8imWMBpXWuS1zvVw@mail.gmail.com>
References: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
 <CAJ3xEMjTDW7sQ5CFmTyR5xMpin_WFFQg-S8imWMBpXWuS1zvVw@mail.gmail.com>
Message-ID: <CAKgT0Ue6tDOE8L4thktyje-erGkVMmtO7zyp0FRgmRPYOppjQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, May 20, 2017 at 2:15 PM, Or Gerlitz <gerlitz.or@gmail.com> wrote:
> On Sat, May 20, 2017 at 3:58 AM, Amritha Nambiar
> <amritha.nambiar@intel.com> wrote:
>> The following series introduces a new harware offload mode in tc/mqprio
>
> Wait, we have already a HW QoS model introduced by John F and Co
> couple of years ago,  right?

I assume you are referring to the ETS portion of DCBX? If so then yes
we have something there, but there is a fairly high level of
complexity and dependencies in order to enable that. What we have in
mind doesn't really fit with DCBX and the problem is the spec calls
out that you really have to have support for DCBX in order to make use
of ETS. What we are trying to do here is provide a lightweight way of
doing this configuration similar to how mqprio was already providing a
lightweight way of enabling multiple traffic classes.

> Please elaborate in few sentence if you are extending it/replacing it,
> why we want to do that and what are the implications on existing
> applications UAPI wise.

This is meant to be an extension of the existing structure. It can be
ignored by the driver and instead only have the basic hw offload
supported. In such a case the command will still return success but
any rate limits and queue configuration can be ignored. In the case of
the current implementation the queue configuration was already being
ignored so we opted to re-purpose the "hw" flag so that if you pass a
value greater than 1 and the driver doesn't recognize the value it has
the option to just ignore the extra bits it doesn't recognize and
return 1 as it did before for the hw flag in mqprio.

> Below you just say in the new mode Qos is configured with knobs XYZ --
> this is way not enough

Can you clarify what you are asking for here? Amritha included an
example in patch 1 of a command line that enabled 2 traffic classes
with rate limits. Is there something more specific you are looking
for?

Thanks.

- Alex
