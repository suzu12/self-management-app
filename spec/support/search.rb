module SearchSupport
  def has_three_team(_teams_tags)
    visit root_path
    expect(@teams_tags.count).to eq 3
  end

  def click_search
    find('.search_nav_right').click
    expect(current_path).to eq filtering_searchs_path
  end

  def exists_team_first_only(_teams_tags)
    expect(page).to have_content @teams_tags.first.team_name
    expect(page).to have_no_content @teams_tags.second.team_name
    expect(page).to have_no_content @teams_tags.third.team_name
  end

  def exists_all_team(_teams_tags)
    expect(page).to have_content @teams_tags.first.team_name
    expect(page).to have_content @teams_tags.second.team_name
    expect(page).to have_content @teams_tags.third.team_name
  end

  def empty_team(_teams_tags)
    expect(page).to have_no_content @teams_tags.first.team_name
    expect(page).to have_no_content @teams_tags.second.team_name
    expect(page).to have_no_content @teams_tags.third.team_name
  end
end
