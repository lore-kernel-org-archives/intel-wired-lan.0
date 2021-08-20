From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 20 Aug 2021 18:00:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor parameters
 name in i40e_print_input_set
In-Reply-To: <20210820103025.9816-1-jedrzej.jagielski@intel.com>
References: <20210820103025.9816-1-jedrzej.jagielski@intel.com>
Message-ID: <945f4edae4f3640bea345d0594ba1d4e672acb1b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-08-20 at 10:30 +0000, Jedrzej Jagielski wrote:
> Change function parameter old/new in i40e_print_input_set.
> To avoid UT compilation problem with old/new name
> added suffix 'input' to the name of parameters.

I'm not familiar with UT compilation. Could you elaborate a little more
on what this is and what the problem is?

Thanks,
Tony

> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

