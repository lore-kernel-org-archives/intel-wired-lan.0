From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 23 Nov 2021 12:36:11 -0800
Subject: [Intel-wired-lan] [igb] netconsole triggers warning in
 netpoll_poll_dev
In-Reply-To: <CAKgT0Uc5ggH24LuKCbSTubDSiTnD5UsLbrC5G6C73rj7ZEnTYQ@mail.gmail.com>
References: <DM6PR12MB45165BFF3AB84602238FA595D89B9@DM6PR12MB4516.namprd12.prod.outlook.com>
 <CAKgT0UfGvcGXAC5VBjXRpR5Y5uAPEPPCsYWjQR8RmW_1kw8TMQ@mail.gmail.com>
 <DM6PR12MB45162662DF7FAF82E7BD2207D89E9@DM6PR12MB4516.namprd12.prod.outlook.com>
 <CAKgT0Uc5ggH24LuKCbSTubDSiTnD5UsLbrC5G6C73rj7ZEnTYQ@mail.gmail.com>
Message-ID: <8de1a0ac-f707-8b45-787c-469ebba4a6ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/21/2021 1:16 PM, Alexander Duyck wrote:
>>> The easiest fix for all of this in the in-kernel driver is to just get rid of the
>>> "min" at the end and instead just "return work_done;". The extra
>>> complication is only needed if you were to be polling multiple queues and
>>> that isn't the case here so we should simplify it and get rid of the buggy
>>> "budget - 1" return value.
>>
>> Thank you very much for your reply Alexander!
>> It seems to work well!
>>
>> Are you planning to send it upstream?
> 
> No, I was just suggesting it as a possible solution. Feel free to put
> together your own patch and submit it if it is working for you.

Thanks for your feedback and work on this, I've prepared a patch and 
will send to netdev and intel-wired-lan shortly.

I don't have an easy way to test this one, please let me know what you 
think.


