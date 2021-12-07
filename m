From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 7 Dec 2021 15:27:42 +0100
Subject: [Intel-wired-lan] [PATCH 2/2] net/ice: Remove unused enum
In-Reply-To: <42f45779-a6e1-9033-376d-4dae36261873@intel.com>
References: <20211124124136.1776-1-shiraz.saleem@intel.com>
 <20211124124136.1776-2-shiraz.saleem@intel.com>
 <6f95e1de-6c35-76e5-eb83-68b60dc55c05@molgen.mpg.de>
 <42f45779-a6e1-9033-376d-4dae36261873@intel.com>
Message-ID: <3ad83995-d7c7-facd-47e3-3275fbab245b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jesse,


Am 29.11.21 um 22:31 schrieb Jesse Brandeburg:
> On 11/24/2021 4:47 AM, Paul Menzel wrote:

>> Am 24.11.21 um 13:41 schrieb Shiraz Saleem:
>>> From: "Shiraz Saleem" <shiraz.saleem@intel.com>
>>>
>>> Remove ice_devlink_param_id enum as its not used.
>>
>> Please add the name `ice_devlink_param_id` to the commit message summary.
> 
> Hi Paul, I don't think that is necessary, is this just personal 
> preference or are you following some style guideline that I don't know 
> about or maybe just don't remember?
> 
> I'd argue that the subject line has a different bug, it should be:
> [PATCH net-next] ice: Remove unused enum
> 
> But I see no reason to add the long string of the actual enum removed to 
> the subject.

Reading through `git log --oneline`, which is also used in the 
announcement emails, the line

> ice: Remove unused enum

would make me need to look into the commit to find out if something 
?important? was removed. Using

> ice: Remove unused enum ice_devlink_param_id

would make that unnecessary for me.


Kind regards,

Paul
