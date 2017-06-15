From: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date: Thu, 15 Jun 2017 16:07:40 -0500
Subject: [Intel-wired-lan] [PATCH] intel: i40e: virtchnl: fix incorrect
 variable assignment
In-Reply-To: <20170615135033.00001ecf@intel.com>
References: <20170615023826.GA8136@embeddedgus>
 <20170615135033.00001ecf@intel.com>
Message-ID: <20170615160740.Horde.Jp_M9DTPyKHhri-Ff7J7hSX@gator4166.hostgator.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jesse,

Quoting Jesse Brandeburg <jesse.brandeburg@intel.com>:

> On Wed, 14 Jun 2017 21:38:26 -0500
> "Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:
>
>> Fix incorrect variable assignment.
>> Based on line 1511: aq_ret = I40_ERR_PARAM; the correct variable to be
>> used in this instance is aq_ret instead of ret. Also, variable ret is
>> updated at line 1602 just before return, so assigning a value to this
>> variable in this code block is useless.
>>
>> Addresses-Coverity-ID: 1397693
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Thanks for the fix, looks reasonable.
> Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Absolutely, glad to help.

Regards
--
Gustavo A. R. Silva




