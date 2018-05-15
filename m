From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 15 May 2018 13:31:30 -0700
Subject: [Intel-wired-lan] i40e - Is i40e_force_link_state doing the
 right thing ?
In-Reply-To: <CABOGejK8bnwU0iqO5-GRO8FX6tCaMYtS+UORPrug3E7LqeWg1Q@mail.gmail.com>
References: <CABOGejK8bnwU0iqO5-GRO8FX6tCaMYtS+UORPrug3E7LqeWg1Q@mail.gmail.com>
Message-ID: <CAKgT0Uf8BcK6hiY7Ff0_XYDMkB2T_mhxmW7oNbyHoPgW=fmG+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 15, 2018 at 1:15 PM, Chaitanya Lala
<chaitanya.lala@gmail.com> wrote:
> Hi,
>
> I am trying to bring up a Intel XL710 4x10G Intel card using the
> latest mainline top-of-tree.
> The problem is that "ifconfig up" and "ifconfig down" do not take
> effect at the link state level.
> I tracked the problem down to i40e_force_link_state() when it is
> called from i40e_down().
> It calls i40e_force_link_state with "is_up" == false. In-turn it
> calls, i40e_aq_set_link_restart_an(hw, true, NULL).
>
> Should the second argument of  i40e_aq_set_link_restart_an be "is_up"
> vs the current "true"
> i.e. i40e_aq_set_link_restart_an(hw, is_up, NULL). ? When I make this
> change, the link state syncs-up with
> the interface administrative state.
>
> Is this a bug ?
>
> Thanks,
> Chaitanya

If you are calling i40e_down the assumption is you are bringing the
interface down, so as not to pass traffic. That is why the "is_up" is
set to false.

Could you provide the dmesg results for when you load the driver and
execute the "ifconfig up" and "ifconfig down" commands? That would
help us to understand what might be going on.

Thanks.

- Alex
