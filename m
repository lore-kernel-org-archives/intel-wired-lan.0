From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 May 2018 21:53:02 -0400
Subject: [Intel-wired-lan] [PATCH v4 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com>
 <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
Message-ID: <2d3c80ee-f990-0619-8107-7a0cb4c76f04@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Andy,

Thank you for your comments. I will send an updated patch soon. My replies are below:

On 05/14/2018 04:04 PM, Andy Shevchenko wrote:

> Can we still preserve an order here? (Yes, even if the entire list is
> not fully ordered)
> In the context I see it would go before netdevice.h.

Sure, I will move kthread.h.

>> +static struct device *
>> +device_get_child_by_index(struct device *parent, int index)
>> +{
>> +       struct klist_iter i;
>> +       struct device *dev = NULL, *d;
>> +       int child_index = 0;
>> +
>> +       if (!parent->p || index < 0)
>> +               return NULL;
>> +
>> +       klist_iter_init(&parent->p->klist_children, &i);
>> +       while ((d = next_device(&i))) {
>> +               if (child_index == index) {
>> +                       dev = d;
>> +                       break;
>> +               }
>> +               child_index++;
>> +       }
>> +       klist_iter_exit(&i);
>> +
>> +       return dev;
>> +}
> 
> This can be implemented as a subfunction to device_find_child(), can't it be?

Yes, but that would make it very inefficient to search for an index in a list via function pointer call.

> 
>> +/**
> 
> Hmm... Why it's marked as kernel doc while it's just a plain comment?
> Same applies to the rest of similar comments.

Fixed this, thanks!

> 
>> +               for (i = 0; i < children_count; i++) {
>> +                       if (device_shutdown_serial) {
>> +                               device_shutdown_child_task(&tdata);
>> +                       } else {
>> +                               kthread_run(device_shutdown_child_task,
>> +                                           &tdata, "device_shutdown.%s",
>> +                                           dev_name(dev));
>> +                       }
>> +               }
> 
> Can't we just use device_for_each_child() instead?

No, at least without doing some memory allocation. Notice in this loop we are not traversing through children, instead we are starting number of children threads, and each thread finds a child to work on. Otherwise we would have to pass child pointer via argument, and we would need to keep that argument in some memory.

Pavel
