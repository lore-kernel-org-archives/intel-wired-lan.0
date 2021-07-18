From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 18 Jul 2021 11:37:45 +0300
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Make mei_me active when
 e1000e is in use
In-Reply-To: <CAAd53p5Pyk80c0FjmqF9cjicNF8t0eTC7Y3BP-rWqW3O53K1Mg@mail.gmail.com>
References: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
 <20210712133500.1126371-2-kai.heng.feng@canonical.com>
 <3947d70a-58d0-df93-24f1-1899fd567534@intel.com>
 <CAAd53p79BwxPGRECYGrpCQbSJz8NY2WrG+AJCuaj89XNqCy59Q@mail.gmail.com>
 <16e188d5-f06e-23dc-2f71-c935240dd3b4@intel.com>
 <CAAd53p5Pyk80c0FjmqF9cjicNF8t0eTC7Y3BP-rWqW3O53K1Mg@mail.gmail.com>
Message-ID: <711813a8-50a6-36da-5d84-cc3c4f64a654@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/14/2021 12:52, Kai-Heng Feng wrote:
> On Wed, Jul 14, 2021 at 5:06 PM Ruinskiy, Dima <dima.ruinskiy@intel.com> wrote:
>>
>> On 14/07/2021 9:28, Kai-Heng Feng wrote:
>>>> I do not know how MEI driver affect 1Gbe driver - so, I would suggest to
>>>> involve our CSME engineer (alexander.usyskin at intel.com) and try to
>>>> investigate this problem.
>>>> Does this problem observed on Dell systems? As I heard no reproduction
>>>> on Intel's RVP platform.
>>>> Another question: does disable mei_me runpm solve your problem?
>>>
>>> Yes, disabling runpm on mei_me can workaround the issue, and that's
>>> essentially what this patch does by adding DL_FLAG_PM_RUNTIME |
>>> DL_FLAG_RPM_ACTIVE flag.
>>>
>>> Kai-Heng
>> Hi, Kai-Heng,
>>
>> If the goal of the patch is to essentially disable runpm on mei_me, then
>> why is the patch touching code in the e1000e driver?
> 
> We can put the workaround in e1000e, mei_me or as PCI quirk.
> But since the bug itself manifests in e1000e, I think it's more
> appropriate to put it here.
> 
> To be more specific, it doesn't disable runtime suspend on mei_me, it
> makes mei_me the power supplier of e1000e.
> So when e1000e can be runtime suspended (i.e. no link partner), mei_me
> can also get runtime suspended too.
>>
>> I agree with Sasha Neftin; it seems like the wrong location, and the
>> wrong way to do it, even if it currently works. We need to understand
>> what causes runpm of mei_me to adversely affect LAN Rx, and for this we
>> need the involvement of mei_me owners.
> 
> I think it's the right location, however I totally agree with your
> other arguments.
> There are many users already affected by this bug, so if a proper fix
> isn't available for now, the temporary workaround can help here.
Hello Kai-Heng,
The temporary workaround without root cause is vague. Please, let's work 
with the manageability FW engineer (alexander.usyskin at intel.com) and 
understand the root cause.
Also, here is interfere with runpm flow of CSME - we must their inputs.
sasha
> 
> Kai-Heng
> 
>>
>> --Dima
>> ---------------------------------------------------------------------
>> Intel Israel (74) Limited
>>
>> This e-mail and any attachments may contain confidential material for
>> the sole use of the intended recipient(s). Any review or distribution
>> by others is strictly prohibited. If you are not the intended
>> recipient, please contact the sender and delete all copies.
