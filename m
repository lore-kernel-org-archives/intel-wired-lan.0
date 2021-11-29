From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 29 Nov 2021 13:31:28 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] net/ice: Remove unused enum
In-Reply-To: <6f95e1de-6c35-76e5-eb83-68b60dc55c05@molgen.mpg.de>
References: <20211124124136.1776-1-shiraz.saleem@intel.com>
 <20211124124136.1776-2-shiraz.saleem@intel.com>
 <6f95e1de-6c35-76e5-eb83-68b60dc55c05@molgen.mpg.de>
Message-ID: <42f45779-a6e1-9033-376d-4dae36261873@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/24/2021 4:47 AM, Paul Menzel wrote:
> Dear Shiraz,
> 
> 
> Am 24.11.21 um 13:41 schrieb Shiraz Saleem:
>> From: "Shiraz Saleem" <shiraz.saleem@intel.com>
>>
>> Remove ice_devlink_param_id enum as its not used.
> 
> Please add the name `ice_devlink_param_id` to the commit message summary.

Hi Paul, I don't think that is necessary, is this just personal 
preference or are you following some style guideline that I don't know 
about or maybe just don't remember?

I'd argue that the subject line has a different bug, it should be:
[PATCH net-next] ice: Remove unused enum

But I see no reason to add the long string of the actual enum removed to 
the subject.

Jesse
